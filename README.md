# demty2025-iam-policies

Proof of execution of the IAM hands-on practice during the bootcamp DE MTY 2025.

La actividad consiste en la creación de roles, grupos de usuarios y usuarios que tengan políticas de acceso distintas sobre un S3, en sus carpetas `private` y `public`.


## User usuario1

The user `usuario1` belongs to the group `GrupoLectoresS3`, which only has read and list permissions on the `public` directory of the S3 Bucket.

**Read, list and copy operations**

![user1 operations](https://github.com/user-attachments/assets/ce63934a-4138-474f-a1a6-94d998e12c71)

**Upload operations**

![user1 upload operations](https://github.com/user-attachments/assets/096defeb-6ae3-48bc-9d35-82267ac99d85)


## User admin-s3

The user `admin-s3` has full access to the S3 Bucket and does not belong to any group.

**List, copy, upload and delete operations**

![admin opeations](https://github.com/user-attachments/assets/756b420b-cbeb-4fee-a747-8b1bd683c61b)


## From the EC2 instance:

An EC2 instance with the assumed role of `EC2S3ReadOnlyRole` is only able to read from both the `public` and `private` folders of the S3 Bucket.

**List, read, copy and upload operations**

![ec2_operaciones](https://github.com/user-attachments/assets/d1651311-8a48-490e-85e8-9b8d2432fdcb)

**Associated role to EC2 instance**
![EC2 ROLE](https://github.com/user-attachments/assets/39c00a49-07bd-478e-9489-ed976e2bfe55)


## JSON Policies

**LecturaS3PublicPolicy**
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::bucket-lab-iam-xidera-oscar",
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "public/*",
                        "",
                        "public"
                    ]
                }
            }
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::bucket-lab-iam-xidera-oscar/public/*"
        }
    ]
}
```

**ECS3ReadOnlyRole**
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::bucket-lab-iam-xidera-oscar",
                "arn:aws:s3:::bucket-lab-iam-xidera-oscar/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Deny",
            "Action": [
                "s3:ReplicateObject",
                "s3:PutObject",
                "s3:DeleteObjectVersion",
                "s3:RestoreObject",
                "s3:DeleteObject",
                "s3:DeleteBucketPolicy"
            ],
            "Resource": [
                "arn:aws:s3:::bucket-lab-iam-xidera-oscar",
                "arn:aws:s3:::bucket-lab-iam-xidera-oscar/*"
            ]
        }
    ]
}
```
