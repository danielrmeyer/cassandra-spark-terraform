sudo apt-get update
sudo apt-get install gcc libev4 libev-dev python-dev
sudo pip install cassandra-driver

#Download scala and install it
wget http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.deb
sudo dpkg -i scala-2.11.7.deb

#git clone https://github.com/datastax/spark-cassandra-connector.git

wget http://apache.arvixe.com/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz
tar -xvf spark-1.5.2-bin-hadoop2.6.tgz

cat <<EOF > run_spark.sh
#!/bin/bash
/home/ubuntu/bin/spark-shell --packages com.datastax.spark:spark-cassandra-connector_2.10:1.5.0-M3
EOF

chmod +x run_spark.sh
