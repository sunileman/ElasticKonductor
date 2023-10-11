import yaml

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
                            "values": ["util"]
                        }
                    ]
                }
            ]
        }
    }
}

# Load all documents from the YAML file
with open("./eck-yamls/operator.yaml", 'r') as file:
    all_docs = list(yaml.safe_load_all(file))

# Modify each document as needed
for data in all_docs:
    if isinstance(data, dict):  # Check if the loaded document is a dictionary
        if data.get('kind') == 'StatefulSet' and data['metadata']['name'] == 'elastic-operator':
            data['spec']['template']['spec']['affinity'] = affinity

# Save the modified data back to the YAML file
with open("./eck-yamls/operator.yaml", 'w') as file:
    for doc in all_docs:
        yaml.safe_dump(doc, file, explicit_start=True)  # explicit_start ensures each document starts with '---'
