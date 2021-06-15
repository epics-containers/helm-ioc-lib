{{- define "ioc-chart.configmap" -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name:  {{ .Release.Name }}
  namespace: {{ .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
    beamline: {{ .Values.beamline }}
    ioc_version: {{ .Chart.AppVersion }}
    is_ioc: "True"
data:

{{ end -}}