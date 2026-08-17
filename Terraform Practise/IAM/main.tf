// iam role always only have trust policy. Permission policy is seperate.
resource "aws_iam_role" "ecs_task_execution_role"{
    name = "ecs-task-execution-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = "sts:AssumeRole"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
            }
        ]
    })
    tags = {
        Name = "ecs-task-execution-role"
    }
}

//Permission policy for the role AWS managed

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    role      = aws_iam_role.ecs_task_execution_role.name
}


// Permission policy for the role custom managed

resource "aws_iam_role_policy" "ecs_task_role_policy" {
    name = "ecs-task-app-permissions"
    role        = aws_iam_role.ecs_task_role.name
    policy      = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
               Effect = "Allow", 
               Action = [
                "s3:GetObject", 
                "s3:PutObject"
                ], 
               Resource = "arn:aws:s3:::app-data-bucket/*"
            },
            {
                Effect = "Allow", 
                Action = "secretsmanager:GetSecretValue", 
                Resource = var.db_secret_arn
            }
        ]

    })
}