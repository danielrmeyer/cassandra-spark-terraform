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