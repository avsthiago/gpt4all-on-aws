# gpt4all-on-aws
Terraform code to host gpt4all on AWS


cd to the directory account_bootstrap and run the following commands:

```
terraform init
terraform apply -var-file=example.tfvars
```

Download the model as suggested by gpt4all as described [here](https://github.com/nomic-ai/gpt4all#try-it-yourself). I only followed the first step of downloading the model. 


We will use the [pylamacpp](https://github.com/nomic-ai/pyllamacpp) library to interact with the model since it is mentioned in the gpt4all documentation as its Official Python Bindings.
```
git clone --recursive https://github.com/nomic-ai/pyllamacpp && cd pyllamacpp
pip install .
```

When trying to use it I got the following error:
```
llama_model_load: loading model from './gpt4all-lora-quantized.bin' - please wait ...
llama_model_load: invalid model file '/gpt4all-lora-quantized.bin' (too old, regenerate your model files or convert them with convert-unversioned-ggml-to-ggml.py!)
llama_init_from_file: failed to load model
llama_generate: seed = 1681233739

```

To solve that I run the following command. The pyllamacpp-convert-gpt4all is a script that comes with the pyllamacpp library. It converts the model to the ggml format.

```
pyllamacpp-convert-gpt4all ./gpt4all-lora-quantized.bin ./tokenizer.model ./gpt4all-lora-quantized-ggml.bin  
```

To push the model to the S3 bucket we created in the previous step, we need to install the AWS CLI. You can follow the steps in the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to get it installed. You might be able to use the AWS Console to upload the model to the S3 bucket but I found it easier to use the CLI.


Then we can push the model to the S3 bucket using the following command (replace the bucket name with the one you created during the account_bootstrap step):

```
aws s3 cp ./gpt4all-lora-quantized-ggml.bin s3://gpt4all-models-xyz/model.bin
```

