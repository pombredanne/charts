{{- define "common.all" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "common.values.setup" . }}
  
  {{- /* Enable OpenVPN VPN add-on if required */ -}}
  {{- if .Values.addons.vpn.enabled }}
    {{- include "common.addon.vpn" . }}
  {{- end -}}

  {{- /* Build the templates */ -}}
  {{- include "common.pvc" . }}
  {{- print "---" | nindent 0 -}}
  {{- if eq .Values.controllerType "statefulset" }}
    {{- include "common.statefulset" . | nindent 0 }}
  {{ else }}
    {{- include "common.deployment" . | nindent 0 }}
  {{- end -}}
  {{- print "---" | nindent 0 -}}
  {{ include "common.service" . | nindent 0 }}
  {{- print "---" | nindent 0 -}}
  {{ include "common.ingress" .  | nindent 0 }}
{{- end -}}
