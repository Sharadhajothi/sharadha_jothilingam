resource "aws_ecs_cluster" "my_ecs"{
    name = "my_ecs_cluster"
}

resource "aws_iam_role" "ecs_task_execution_role"{
    name = "ecs_task_execution_role"

    assume_role_policy= jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy"{
    role = aws_iam_role.ecs_task_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "ecs_task_role"{
    name = "ecs_task_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
        }]
        
    })
}

resource "aws_iam_role_policy_attachment" "ecs_task_task_role"{
    role = aws_iam_role.ecs_task_role.name
    policy_arn = ""
}

resource "aws_ecs_task_definition" "task_definition"{
    family =  "my_ecs"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu ="256"
    memory = "512"
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
    task_role_arn = aws_iam_role.ecs_task_role.arn
    container_definitions = jsonencode([{
        name = "first_conatiner"
        image = "nginx:latest"
        cpu = "256"
        memory = "512"
        portMappings = [{
            containerPort = 8080
            hostPort = 80
        }]
        logConfiguration = {
            logDriver = "awslogs"
            options = {
                awslogs-group = "/ecs/my_ecs"
                awslogs-region = "us-east-1"
                awslogs-stream-prefix = "ecs"
            }
        }
        essential = true
    }])
}

resource "aws_ecs_service" "my_ecs_service"{
    name = "my_ecs_service"
    cluster = aws_ecs_cluster.my_ecs.id
    task_definition = aws_ecs_task_definition.task_definition.arn
    desired_count = 1
    launch_type = "FARGATE"
    network_configuration {
        subnets = [var.subnet_id]
        security_groups = [var.security_group_id]
    }

}

//Cloudwatch

resource "aws_cloudwatch_log_group" "ecs_log_group"{
    name = "/ecs/my_ecs"
    retention_in_days = 30
}

resource "aws_sns_topic" "ecs_sns_topic"{
    name = "ecs_sns_topic"
}

resource "aws_cloudwatch_metric_alarm" "ecs_metric_alarm"{
    alarm_name = "ecs_metric_alarm"
    metric_name = "CPUUtilization"
    namespace = "AWS/ECS"
    statistic = "Average"
    period = 300
    evaluation_periods = 3
    threshold = 80
    comparison_operator = "GreaterThanOrEqualToThreshold"
    alarm_actions = [aws_sns_topic.ecs_sns_topic.arn]
    dimensions = {
  ClusterName = aws_ecs_cluster.my_ecs.name
  ServiceName = aws_ecs_service.my_ecs_service.name
}
}