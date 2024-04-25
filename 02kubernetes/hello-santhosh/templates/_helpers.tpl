{{/* vim: set filetype=mustache: */}}
{{- define "hello-santhosh.name" -}}
{{- default "hello-santhosh" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hello-santhosh.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- template "hello-santhosh.name" . -}}
{{- end -}}
{{- end -}}