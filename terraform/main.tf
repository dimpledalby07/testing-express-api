resource "aws_s3_bucket_object" "app_zip" {
  bucket = "app_zip_bucket"
  key    = "express-api.zip"
  source = "../express-api.zip"
  etag   = "${md5(file("../express-api.zip"))}"
}

resource "aws_elastic_beanstalk_application" "testing-express-api" {
  name        = "testing-express-api"
  description = "express-api"
}

# define elastic beanstalk app version "latest"
resource "aws_elastic_beanstalk_application_version" "latest" {
  name        = "latest"
  application = "${aws_elastic_beanstalk_application.testing-express-api.name}"
  description = "application version created by terraform"
  bucket      = "app_zip_bucket"
  key         = "express_api"
  depends_on  = ["aws_elastic_beanstalk_application.testing-express-api"]
}


resource "aws_elastic_beanstalk_environment" "testing-express-api-env" {
  name        = "testing-express-api"
  application = "${aws_elastic_beanstalk_application.testing-express-api.name}"

  solution_stack_name = "64bit Amazon Linux 2017.03 v2.6.2 running Tomcat 8 Java 8"

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