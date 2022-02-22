package compliance.cis_k8s.rules.cis_4_1_1

import data.compliance.cis_k8s
import data.compliance.lib.common
import data.compliance.lib.data_adapter

# Ensure that the kubelet service file permissions are set to 644 or more restrictive (Automated)
finding = result {
	data_adapter.filename == "10-kubeadm.conf"
	filemode := data_adapter.filemode
	rule_evaluation := common.file_permission_match(filemode, 6, 4, 4)

	# set result
	result := {
		"evaluation": common.calculate_result(rule_evaluation),
		"evidence": {"filemode": filemode},
	}
}

metadata = {
	"name": "Ensure that the kubelet service file permissions are set to 644 or more restrictive",
	"description": "Ensure that the kubelet service file has permissions of 644 or more restrictive.",
	"impact": "None",
	"tags": array.concat(cis_k8s.default_tags, ["CIS 4.1.1", "Worker Node Configuration"]),
	"benchmark": cis_k8s.benchmark_metadata,
	"remediation": "Run the below command (based on the file location on your system) on the each worker node. For example, chmod 755 /etc/systemd/system/kubelet.service.d/10-kubeadm.conf",
}
