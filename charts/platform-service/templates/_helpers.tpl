{{- define "platform-service.name" -}}platform-demo{{- end -}}
{{- define "platform-service.labels" -}}
app.kubernetes.io/name: {{ include "platform-service.name" . }}
app.kubernetes.io/managed-by: Helm
{{- end -}}
