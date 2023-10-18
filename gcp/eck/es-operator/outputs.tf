output "elastic_operator_doc_manifests" {
  value = data.kubectl_file_documents.elastic_operator_doc.manifests
  description = "Manifests for the elastic operator doc"
}