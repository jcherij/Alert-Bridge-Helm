{{- define "vitalbridge.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "vitalbridge.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "vitalbridge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "vitalbridge.labels" -}}
helm.sh/chart: {{ include "vitalbridge.chart" . }}
app.kubernetes.io/name: {{ include "vitalbridge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: vitalbridge
data-sensitivity: phi
hipaa-scope: "true"
{{- end }}

{{- define "vitalbridge.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vitalbridge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "vitalbridge.ingestLabels" -}}
{{ include "vitalbridge.selectorLabels" . }}
app.kubernetes.io/component: ingest
{{- end }}

{{- define "vitalbridge.processorLabels" -}}
{{ include "vitalbridge.selectorLabels" . }}
app.kubernetes.io/component: processor
{{- end }}

{{- define "vitalbridge.alertLabels" -}}
{{ include "vitalbridge.selectorLabels" . }}
app.kubernetes.io/component: alert-evaluator
{{- end }}
