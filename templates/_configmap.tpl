{{- define "ioc-chart.configmap" -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name:  {{ .Chart.Name }}
  namespace: {{ .Values.namespace }}
  labels:
    app: {{ .Chart.Name }}
    beamline: {{ .Values.beamline }}
    ioc_version: {{ .Chart.AppVersion | quote }}
    is_ioc: "True"
data:

{{ end -}}