resource "aws_db_subnet_group" "db_subnet_group"{
    name = "app-db-subnet-group"
    subnet_ids = var.private_subnet_ids
    tags = {
        Name = "app-db-subnet-group"
    }
}

resource "aws_security_group" "db_sg"{
    vpc_id = var.vpc_id

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.target_sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "app-db-sg"
    }
}

resource "aws_db_parameter_group" "db_param_group" {
    name = "app-db-params"
    family = "postgres15"
    parameter {
        name = "log_connections"
        value = "1"
    }
  
}

resource "aws_db_instance" "app_db" {
    identifier = "app-db"
    engine = "postgres"
    engine_version = "15.4"
    instance_class = "db.t3.medium"
    allocated_storage = 20
    db_name = "appdb"
    username = "dbadmin"
    password = var.db_password
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    parameter_group_name = aws_db_parameter_group.db_param_group.name
    multi_az = true
    backup_retention_period = 7
    skip_final_snapshot = true
}