import yaml
import os
from robot.libraries.BuiltIn import BuiltIn

def load_suite_data():
    """
    Reads the YAML file and returns the section matching the running test name.
    """
    built_in = BuiltIn()
    
    # Get the current robot file path and derive its name
    # Using ${SUITE SOURCE} to find the file location
    source = built_in.get_variable_value('${SUITE SOURCE}')
    suite_name = os.path.splitext(os.path.basename(source))[0]
    test_name = built_in.get_variable_value('${TEST NAME}')
    
    # Construct path: assumes yaml is in ../resources/test_data.yaml relative to the suite
    yaml_path = os.path.join(os.path.dirname(source), '..', 'resources', 'test_data.yaml')
    
    with open(os.path.abspath(yaml_path), "r") as f:
        all_data = yaml.safe_load(f)

    # Validate that the suite and test keys exist in your YAML structure
    if suite_name not in all_data:
        raise KeyError(f"Suite '{suite_name}' not found in YAML data.")
    
    if test_name not in all_data[suite_name]:
        raise KeyError(f"Test '{test_name}' not found under suite '{suite_name}'.")
        
    return all_data[suite_name][test_name]