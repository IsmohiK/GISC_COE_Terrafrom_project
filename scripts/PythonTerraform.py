''''
python-terraform is a python module provide a wrapper of terraform command line tool.
'''

from python_terraform import *
import yaml
import json
import sys

def PythonTerraform(choice):
	#### Reading teh manifest file for E2 config ####
	env_dict = {'1':'dev','2':'test'}
	cwd = os.getcwd()
	print("Current working directory : " ,cwd)
	with open("scripts\\manifest.yaml", "r") as f:
		config = yaml.safe_load(f)
		f.close()
	vars_dict = config['params'][env_dict[str(choice)]]
	##vars_dict = {
	##	'desiredCapacity':config['params'][env_dict[str(choice)]]['desiredCapacity'],
	##	'region':config['params'][env_dict[str(choice)]]['region'],
	##	'ami-name':config['params']['default']['ami-name'],
	##	'instance_type':config['params'][env_dict[str(choice)]]['instance_type'],
	##	'profile':config['params'][env_dict[str(choice)]]['profile'],
	##	'name':config['params'][env_dict[str(choice)]]['name'],
	##	's3_bucket_name':config['params'][env_dict[str(choice)]]['s3_bucket_name'],
	##	'dynamodb_name':config['params'][env_dict[str(choice)]]['dynamodb_name'],
	##	'environment':config['params'][env_dict[str(choice)]]['environment']
	##}
	print(vars_dict)
	if env_dict[str(choice)] == "dev":
		cwd = cwd + "\\dev"
		print("Current working directory : " ,cwd)
	elif env_dict[str(choice)] == "test":
		cwd = cwd + "\\test"
		print("Current working directory : " ,cwd)

	approve = {"auto-approve": True, "capture_output":True}
	tf = Terraform(working_dir=cwd,variables=vars_dict)
	print("Terraform init started")
	##tuple_output = tf.init(reconfigure=True,backend_config=env_dict[str(choice)]+".tfbackend",force_copy=True)
	tuple_output = tf.init()
	print(tuple_output[-1])
	print(tuple_output[-2])
	print("Terraform init completed")
	'''
	Run terraform plan to check whether the execution plan for a configuration matches your 
	expectations before provisioning or changing infrastructure.
	'''
	print("Terraform plan started")
	tuple_output = tf.plan(capture_output=True,refresh=True)
	print(tuple_output[-1])
	print(tuple_output[-2])
	print("Terraform plan completed")
	
	'''
	Apply changes to hundreds of cloud providers with terraform apply 
	to reach the desired state of the configuration.
	'''
	print("Terraform apply started")
	print("Type yes to perform terraform apply")
	tuple_output = tf.apply(**approve)
	print(tuple_output[-1])
	print(tuple_output[-2])
	print("Terraform apply completed. Check AWS for cross verifying the setup")


