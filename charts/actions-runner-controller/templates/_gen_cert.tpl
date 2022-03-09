{{- define "generatedCert" }}
{{- $expire := (int $.Values.admissionWebHooks.generatedCert.expireDate) }}
{{- $ca := genCA (include "actions-runner-controller.name" .) $expire }}
{{- $domain1 := printf "%s.%s.svc" (include "actions-runner-controller.webhookServiceName" .) $.Release.Namespace }}
{{- $domain2 := printf "%s.%s.svc.cluster.local" (include "actions-runner-controller.webhookServiceName" .) $.Release.Namespace }}
{{- $domains := list $domain1 $domain2 }}
{{- $cert := genSignedCert (include "actions-runner-controller.webhookServiceName" .) nil $domains $expire $ca }}
caCert: {{ $ca.Cert | b64enc }}
clientCert: {{ $cert.Cert | b64enc }}
clientKey: {{ $cert.Key | b64enc }}
{{- end }}
