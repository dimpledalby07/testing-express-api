
resource "aws_s3_bucket" "app-zip-bucket" {
  bucket   = "app-zip-bucket"
  region   = "eu-west-2"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "app_zip_object" {
  bucket = "${aws_s3_bucket.app-zip-bucket.id}"
  key    = "express-api.zip"
  source = "../express-api.zip"
  etag   = "${md5(file("../express-api.zip"))}"
}

resource "aws_elastic_beanstalk_application" "express-api" {
  name        = "express-api"
  description = "express-api"
}

# define elastic beanstalk app version "latest"
resource "aws_elastic_beanstalk_application_version" "latest" {
  name        = "latest"
  application = "${aws_elastic_beanstalk_application.express-api.name}"
  description = "application version created by terraform"
  bucket      = "${aws_s3_bucket.app-zip-bucket.id}"
  key         = "express-api.zip"
  depends_on  = ["aws_elastic_beanstalk_application.express-api"]
}


resource "aws_elastic_beanstalk_environment" "express-api-env" {
  name        = "express-api-env"
  application = "${aws_elastic_beanstalk_application.express-api.name}"

  solution_stack_name = "64bit Amazon Linux 2017.09 v4.4.5 running Node.js"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

   setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
   tags {
    Team = ""
    Environment = ""
  }
   setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }
 setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "ConfigDocument"
    value = "{\"CloudWatchMetrics\": {\"Environment\": {\"ApplicationLatencyP99.9\": 60,\"InstancesSevere\": 60,\"ApplicationLatencyP90\": 60,\"ApplicationLatencyP99\": 60,\"ApplicationLatencyP95\": 60,\"InstancesUnknown\": 60,\"ApplicationLatencyP85\": 60,\"InstancesInfo\": 60,\"ApplicationRequests2xx\": 60,\"InstancesDegraded\": 60,\"InstancesWarning\": 60,\"ApplicationLatencyP50\": 60,\"ApplicationRequestsTotal\": 60,\"InstancesNoData\": 60,\"InstancesPending\": 60,\"ApplicationLatencyP10\": 60,\"ApplicationRequests5xx\": 60,\"ApplicationLatencyP75\": 60,\"InstancesOk\": 60,\"ApplicationRequests3xx\": 60,\"ApplicationRequests4xx\": 60},\"Instance\": {\"ApplicationLatencyP99.9\": 60,\"ApplicationLatencyP90\": 60,\"ApplicationLatencyP99\": 60,\"ApplicationLatencyP95\": 60,\"ApplicationLatencyP85\": 60,\"CPUUser\": 60,\"ApplicationRequests2xx\": 60,\"CPUIdle\": 60,\"ApplicationLatencyP50\": 60,\"ApplicationRequestsTotal\": 60,\"RootFilesystemUtil\": 60,\"LoadAverage1min\": 60,\"CPUIrq\": 60,\"CPUNice\": 60,\"CPUIowait\": 60,\"ApplicationLatencyP10\": 60,\"LoadAverage5min\": 60,\"ApplicationRequests5xx\": 60,\"ApplicationLatencyP75\": 60,\"CPUSystem\": 60,\"ApplicationRequests3xx\": 60,\"ApplicationRequests4xx\": 60,\"InstanceHealth\": 60,\"CPUSoftirq\": 60}},\"Version\": 1}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name ="StreamLogs"
      value = "True"
  }
}