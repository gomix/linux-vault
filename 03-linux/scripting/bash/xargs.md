
```bash
%> oc get csr -o name | xargs -n1 oc adm certificate approve                                                                           
certificatesigningrequest.certificates.k8s.io/csr-4qf5b approved
certificatesigningrequest.certificates.k8s.io/csr-7ftfq approved
certificatesigningrequest.certificates.k8s.io/csr-cjzs6 approved
```