num=$1
#gcloud authentication
gcloud auth activate-service-account --key-file /home/reddisekhara_n/name.json 
export GOOGLE_CLOUD_KEYFILE_JSON=/home/reddisekhara_n/name.json

#number of vm's to be created
sed -i "s/count =.*/count = $num/g" main.tf

#vm creation
terraform init
terraform plan -out out.terraform
terraform apply out.terraform

#list of vm's created
gcloud compute instances list | awk '{print $5}'
