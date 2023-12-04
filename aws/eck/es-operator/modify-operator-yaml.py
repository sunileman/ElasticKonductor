import yaml
import sys
import json
import hcl2


# Get the input from the 'query'
input_data = json.load(sys.stdin)
original_yaml = input_data['yaml_content']

# Read the input YAML. Note: This now handles multiple documents.
documents = list(yaml.safe_load_all(original_yaml))

def read_tfvars(file_path, variable_name):
    with open(file_path, 'r') as file:
        parsed_vars = hcl2.load(file)
        return parsed_vars.get(variable_name, None)

eck_operator_instance_affinity = read_tfvars('./terraform.tfvars', 'eck_operator_instance_affinity')

# Define the affinity block
affinity = {
    "nodeAffinity": {
        "requiredDuringSchedulingIgnoredDuringExecution": {
            "nodeSelectorTerms": [
                {
                    "matchExpressions": [
                        {
                            "key": "nodetype",
                            "operator": "In",
                            "values": [eck_operator_instance_affinity]
                        }
                    ]
                }
            ]
        }
    }
}

# Modify each document in the YAML
for data in documents:
    # Locate the StatefulSet with the name 'elastic-operator'
    if isinstance(data, dict) and data.get('kind') == 'StatefulSet' and data.get('metadata', {}).get('name') == 'elastic-operator':
        data['spec']['template']['spec']['affinity'] = affinity

# Return the modified YAML as a single string with documents separated by ---
modified_yaml = "\n---\n".join([yaml.safe_dump(doc) for doc in documents])

output = {
    "modified_yaml": modified_yaml
}

print(json.dumps(output))