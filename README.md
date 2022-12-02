# eks-kubeconfig   
Update kubeconfig file in github runner

## Example   

### Inputs   
AWS_ACCESS_KEY_ID   
AWS_SECRET_ACCESS_KEY   
AWS Region of EKS cluster
EKS Cluster name   

### Code snippets   

```
jobs:
    runs-on: ubuntu-latest 
    steps:
      - name: Build and push CONTAINER_NAME
        uses: arulkandas/github-action-eks-kube-config@master
        with:
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws_region: ${{ secrets.AWS_REGION }}
          cluster_name: ${{ secrets.CLUSTER_NAME }}
```