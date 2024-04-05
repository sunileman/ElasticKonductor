import subprocess
import json

# Execute the kubectl get service command with JSON output
command = ["kubectl", "get", "service", "eck-kibana-kb-http", "-o", "json"]
result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

if result.returncode == 0:  # Check if the command was successful
    # Parse the JSON output
    service_info = json.loads(result.stdout)

    # Extract the annotation value
    annotation_key = "service.beta.kubernetes.io/azure-dns-label-name"
    annotation_value = service_info.get("metadata", {}).get("annotations", {}).get(annotation_key)

    if annotation_value:
        print(annotation_value)  # Print the annotation value
    else:
        print("Annotation not found.")
else:
    # Command failed
    print("Failed to execute command:", result.stderr)
