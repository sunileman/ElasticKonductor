import requests
import sys
import os

if len(sys.argv) < 2:
    print("Usage: python fetch_yaml.py <eck_version>")
    sys.exit(1)

eck_version = sys.argv[1]
url = f"https://download.elastic.co/downloads/eck/{eck_version}/operator.yaml"
response = requests.get(url)

if response.status_code == 200:
    os.makedirs('./eck-yamls', exist_ok=True)
    
    # Check if the file exists and delete it
    file_path = './eck-yamls/operator.yaml'
    if os.path.exists(file_path):
        os.remove(file_path)
    
    # Now write the new content
    with open(file_path, 'w') as file:
        file.write(response.text)
else:
    print(f"Failed to fetch the file. Status code: {response.status_code}")
    sys.exit(1)