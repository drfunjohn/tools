# tools
my amazing tools

1. ## Live server __run-deamon.sh__

- allow restart server if any of the monitored files is changed.
By default the ".go" files are monitored only.
During restart script looking for chain of precesses run by main process and
kill before run again
Requirements: preinstalled [emcrisostomo/fswatch](https://github.com/emcrisostomo/fswatch)

_Usage_:

```shell
    brew install fswatch # run once to install at MacOS
    cd <path_of_your_project>
    <path>/run-deamon.sh "<command to run server>"
```

2. ## Update deployment __publish-chart.sh__ 

- generate chart from helm and upgrade it in the any
   currently active cloud cluster. Use "make helm" and "helm upgrade". Version is taken from latest tag of git
   Requiemets: 
   - cloud cluster seted, for exemple: `kubectl config use-context <cluster's config name>`
   - helm installed

__Usage_:

```shell
    ./publish-chart.sh
```
