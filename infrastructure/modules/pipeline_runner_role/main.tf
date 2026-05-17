###############################################################################
# Custom role: pipeline_runner
#
# Grants the minimum set of permissions required to:
#   * Run ELT jobs on GKE / Kubeflow (Vertex AI Pipelines)
#   * Read and write data in BigQuery
#   * Read and write objects in Google Cloud Storage
#   * Pull container images from Artifact Registry
#   * Write logs and metrics for observability
#
# Built on top of: terraform-google-modules/iam/google//modules/custom_role_iam
###############################################################################

module "pipeline_runner_role" {
  source  = "terraform-google-modules/iam/google//modules/custom_role_iam"
  version = "~> 8.2"

  target_level = "project"
  target_id    = var.project_id

  role_id     = var.role_id
  title       = var.title
  description = var.description
  stage       = var.stage
  members     = var.members

  permissions = [
    # ---------------------------------------------------------------------
    # GKE / Kubernetes  -- obtain cluster credentials and run workloads.
    # The actual Kubernetes-level RBAC (Pods, Jobs, etc.) is managed
    # inside the cluster; here we only grant what is needed at the GCP
    # IAM layer so that `gcloud container clusters get-credentials` and
    # subsequent kubectl/Kubeflow API calls work.
    # ---------------------------------------------------------------------
    "container.clusters.get",
    "container.clusters.getCredentials",
    "container.clusters.list",
    "container.operations.get",
    "container.operations.list",

    # ---------------------------------------------------------------------
    # Vertex AI Pipelines (managed Kubeflow Pipelines)
    # ---------------------------------------------------------------------
    "aiplatform.pipelineJobs.create",
    "aiplatform.pipelineJobs.get",
    "aiplatform.pipelineJobs.list",
    "aiplatform.pipelineJobs.cancel",
    "aiplatform.customJobs.create",
    "aiplatform.customJobs.get",
    "aiplatform.customJobs.list",
    "aiplatform.customJobs.cancel",
    "aiplatform.metadataStores.get",
    "aiplatform.metadataStores.list",

    # ---------------------------------------------------------------------
    # BigQuery -- read & write data, run query/load/extract jobs.
    # ---------------------------------------------------------------------
    "bigquery.jobs.create",
    "bigquery.jobs.get",
    "bigquery.jobs.list",
    "bigquery.jobs.update",
    "bigquery.datasets.get",
    "bigquery.datasets.getIamPolicy",
    "bigquery.tables.create",
    "bigquery.tables.delete",
    "bigquery.tables.get",
    "bigquery.tables.getData",
    "bigquery.tables.list",
    "bigquery.tables.update",
    "bigquery.tables.updateData",
    "bigquery.tables.export",
    "bigquery.routines.get",
    "bigquery.routines.list",
    "bigquery.readsessions.create",
    "bigquery.readsessions.getData",
    "bigquery.readsessions.update",

    # ---------------------------------------------------------------------
    # Cloud Storage -- read/write staging buckets and the raw data lake.
    # ---------------------------------------------------------------------
    "storage.buckets.get",
    "storage.buckets.list",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list",
    "storage.objects.update",

    # ---------------------------------------------------------------------
    # Artifact Registry -- pull pipeline step container images.
    # ---------------------------------------------------------------------
    "artifactregistry.repositories.get",
    "artifactregistry.repositories.list",
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.files.get",
    "artifactregistry.files.list",
    "artifactregistry.tags.get",
    "artifactregistry.tags.list",
    "artifactregistry.versions.get",
    "artifactregistry.versions.list",

    # ---------------------------------------------------------------------
    # Secret Manager -- read pipeline credentials (DB passwords, API keys).
    # ---------------------------------------------------------------------
    "secretmanager.secrets.get",
    "secretmanager.secrets.list",
    "secretmanager.versions.get",
    "secretmanager.versions.list",
    "secretmanager.versions.access",

    # ---------------------------------------------------------------------
    # Service-account token creation -- required when the pipeline-runner
    # SA needs to impersonate other SAs (e.g. workload identity, Vertex
    # AI custom training service agent).
    # ---------------------------------------------------------------------
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.getAccessToken",
    "iam.serviceAccounts.signBlob",
    "iam.serviceAccounts.signJwt",

    # ---------------------------------------------------------------------
    # Logging & Monitoring -- write logs/metrics from pipeline steps.
    # ---------------------------------------------------------------------
    "logging.logEntries.create",
    "monitoring.timeSeries.create",
    "monitoring.metricDescriptors.create",
    "monitoring.metricDescriptors.get",
    "monitoring.metricDescriptors.list",
  ]
}
