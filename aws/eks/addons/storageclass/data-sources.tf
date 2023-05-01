data "terraform_remote_state" "k8s" {
  backend = "local"

  config = {
    path = "../../terraform.tfstate"
  }
}



data "kubectl_path_documents" "master-gp3" {
    pattern = "./yamls/master-gp3.yaml"
    vars = {
        master_pod_storage_class = var.master_pod_storage_class
        master_pod_storage_class = var.master_pod_storage_class
        master_pod_storage_class_iops = var.master_pod_storage_class_iops
        master_pod_storage_class_throughput = var.master_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "master-gp3-count" {
    pattern = "./yamls/master-gp3.yaml"
    vars = {
        master_pod_storage_class = ""
        master_pod_storage_class = ""
        master_pod_storage_class_iops = ""
        master_pod_storage_class_throughput = ""
    }
}


data "kubectl_path_documents" "master-io2-be" {
    pattern = "./yamls/master-io2-be.yaml"
    vars = {
        master_pod_storage_class = var.master_pod_storage_class
        master_pod_storage_class = var.master_pod_storage_class
        master_pod_storage_class_iops = var.master_pod_storage_class_iops
        master_pod_storage_class_throughput = var.master_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "master-io2-be-count" {
    pattern = "./yamls/master-io2-be.yaml"
    vars = {
        master_pod_storage_class = ""
        master_pod_storage_class = ""
        master_pod_storage_class_iops = ""
        master_pod_storage_class_throughput = ""
    }
}



data "kubectl_path_documents" "hot-gp3" {
    pattern = "./yamls/hot-gp3.yaml"
    vars = {
        hot_pod_storage_class = var.hot_pod_storage_class
        hot_pod_storage_class = var.hot_pod_storage_class
        hot_pod_storage_class_iops = var.hot_pod_storage_class_iops
        hot_pod_storage_class_throughput = var.hot_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "hot-gp3-count" {
    pattern = "./yamls/hot-gp3.yaml"
    vars = {
        hot_pod_storage_class = ""
        hot_pod_storage_class = ""
        hot_pod_storage_class_iops = ""
        hot_pod_storage_class_throughput = ""
    }
}


data "kubectl_path_documents" "hot-io2-be" {
    pattern = "./yamls/hot-io2-be.yaml"
    vars = {
        hot_pod_storage_class = var.hot_pod_storage_class
        hot_pod_storage_class = var.hot_pod_storage_class
        hot_pod_storage_class_iops = var.hot_pod_storage_class_iops
        hot_pod_storage_class_throughput = var.hot_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "hot-io2-be-count" {
    pattern = "./yamls/hot-io2-be.yaml"
    vars = {
        hot_pod_storage_class = ""
        hot_pod_storage_class = ""
        hot_pod_storage_class_iops = ""
        hot_pod_storage_class_throughput = ""
    }
}


data "kubectl_path_documents" "warm-gp3" {
    pattern = "./yamls/warm-gp3.yaml"
    vars = {
        warm_pod_storage_class = var.warm_pod_storage_class
        warm_pod_storage_class = var.warm_pod_storage_class
        warm_pod_storage_class_iops = var.warm_pod_storage_class_iops
        warm_pod_storage_class_throughput = var.warm_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "warm-gp3-count" {
    pattern = "./yamls/warm-gp3.yaml"
    vars = {
        warm_pod_storage_class = ""
        warm_pod_storage_class = ""
        warm_pod_storage_class_iops = ""
        warm_pod_storage_class_throughput = ""
    }
}


data "kubectl_path_documents" "warm-io2-be" {
    pattern = "./yamls/warm-io2-be.yaml"
    vars = {
        warm_pod_storage_class = var.warm_pod_storage_class
        warm_pod_storage_class = var.warm_pod_storage_class
        warm_pod_storage_class_iops = var.warm_pod_storage_class_iops
        warm_pod_storage_class_throughput = var.warm_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "warm-io2-be-count" {
    pattern = "./yamls/warm-io2-be.yaml"
    vars = {
        warm_pod_storage_class = ""
        warm_pod_storage_class = ""
        warm_pod_storage_class_iops = ""
        warm_pod_storage_class_throughput = ""
    }
}

data "kubectl_path_documents" "cold-gp3" {
    pattern = "./yamls/cold-gp3.yaml"
    vars = {
        cold_pod_storage_class = var.cold_pod_storage_class
        cold_pod_storage_class = var.cold_pod_storage_class
        cold_pod_storage_class_iops = var.cold_pod_storage_class_iops
        cold_pod_storage_class_throughput = var.cold_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "cold-gp3-count" {
    pattern = "./yamls/cold-gp3.yaml"
    vars = {
        cold_pod_storage_class = ""
        cold_pod_storage_class = ""
        cold_pod_storage_class_iops = ""
        cold_pod_storage_class_throughput = ""
    }
}

data "kubectl_path_documents" "cold-io2-be" {
    pattern = "./yamls/cold-io2-be.yaml"
    vars = {
        cold_pod_storage_class = var.cold_pod_storage_class
        cold_pod_storage_class = var.cold_pod_storage_class
        cold_pod_storage_class_iops = var.cold_pod_storage_class_iops
        cold_pod_storage_class_throughput = var.cold_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "cold-io2-be-count" {
    pattern = "./yamls/cold-io2-be.yaml"
    vars = {
        cold_pod_storage_class = ""
        cold_pod_storage_class = ""
        cold_pod_storage_class_iops = ""
        cold_pod_storage_class_throughput = ""
    }
}

data "kubectl_path_documents" "frozen-gp3" {
    pattern = "./yamls/frozen-gp3.yaml"
    vars = {
        frozen_pod_storage_class = var.frozen_pod_storage_class
        frozen_pod_storage_class = var.frozen_pod_storage_class
        frozen_pod_storage_class_iops = var.frozen_pod_storage_class_iops
        frozen_pod_storage_class_throughput = var.frozen_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "frozen-gp3-count" {
    pattern = "./yamls/frozen-gp3.yaml"
    vars = {
        frozen_pod_storage_class = ""
        frozen_pod_storage_class = ""
        frozen_pod_storage_class_iops = ""
        frozen_pod_storage_class_throughput = ""
    }
}

data "kubectl_path_documents" "frozen-io2-be" {
    pattern = "./yamls/frozen-io2-be.yaml"
    vars = {
        frozen_pod_storage_class = var.frozen_pod_storage_class
        frozen_pod_storage_class = var.frozen_pod_storage_class
        frozen_pod_storage_class_iops = var.frozen_pod_storage_class_iops
        frozen_pod_storage_class_throughput = var.frozen_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "frozen-io2-be-count" {
    pattern = "./yamls/frozen-io2-be.yaml"
    vars = {
        frozen_pod_storage_class = ""
        frozen_pod_storage_class = ""
        frozen_pod_storage_class_iops = ""
        frozen_pod_storage_class_throughput = ""
    }
}


data "kubectl_path_documents" "ml-gp3" {
    pattern = "./yamls/ml-gp3.yaml"
    vars = {
        ml_pod_storage_class = var.ml_pod_storage_class
        ml_pod_storage_class = var.ml_pod_storage_class
        ml_pod_storage_class_iops = var.ml_pod_storage_class_iops
        ml_pod_storage_class_throughput = var.ml_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "ml-gp3-count" {
    pattern = "./yamls/ml-gp3.yaml"
    vars = {
        ml_pod_storage_class = ""
        ml_pod_storage_class = ""
        ml_pod_storage_class_iops = ""
        ml_pod_storage_class_throughput = ""
    }
}


data "kubectl_path_documents" "ml-io2-be" {
    pattern = "./yamls/ml-io2-be.yaml"
    vars = {
        ml_pod_storage_class = var.ml_pod_storage_class
        ml_pod_storage_class = var.ml_pod_storage_class
        ml_pod_storage_class_iops = var.ml_pod_storage_class_iops
        ml_pod_storage_class_throughput = var.ml_pod_storage_class_throughput
    }
}


data "kubectl_path_documents" "ml-io2-be-count" {
    pattern = "./yamls/ml-io2-be.yaml"
    vars = {
        ml_pod_storage_class = ""
        ml_pod_storage_class = ""
        ml_pod_storage_class_iops = ""
        ml_pod_storage_class_throughput = ""
    }
}


