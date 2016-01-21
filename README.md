##Quickly get a spark/cassandra node up in ec2 for testing

Create a file called terraform.tfvars like
```
user_name = "my_user_name"
access_key = "###################"
secret_key = "#######################################"
ssh_key_path = "/path/to/key"
ssh_key_name = "keyname"
vpc_id = "vpc-########"
```

Once you have created the above file (please read up on EC2 and terraform docs):
```bash
terraform plan
```
If the plan looks good:
```bash
terraform apply
```

Once the instance has been provisioned, ssh into it and run the following:

* Setup and spark installation
```bash
bash /tmp/provisioning/setup.sh
```

* Load some sample data into cassandra
```bash
python /tmp/provisioning/load_data.py
```

* Fire up spark shell with cassandra integration
```bash
#In the same directory that you ran setup.sh
./run_spark.sh
```


