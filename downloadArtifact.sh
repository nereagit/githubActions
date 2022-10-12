#get artifact - harcoded url
#gh api -H "Accept: application/vnd.github+json" /repos/nereagit/githubActions/actions/artifacts/374902573/zip

#get artifact for specific branch 
#gh api -H "Accept: application/vnd.github+json" /repos/nereagit/githubActions/actions/artifacts --jq -r ".artifacts[] | select(.workflow_run.head_branch == \"concurrency-job-level\") | {archive_download_url}" 

#Dinamically get the url or the name of the artifact associated to the current branch 
#content=$( gh api -H "Accept: application/vnd.github+json" /repos/nereagit/githubActions/actions/artifacts --jq  ".artifacts[] | select(.workflow_run.head_branch == \"concurrency-job-level\") | {archive_download_url}") 
#archive_download_url=$( jq -r  '.archive_download_url' <<< "${content}" ) 
#echo "${archive_download_url}"

#Download the artifact found in the previous steps
#artifactFile=$(gh api -H "Accept: application/vnd.github+json" "${archive_download_url}")
artifactFile=$(gh run download -n "concurrency-job-level") #maybe use the artifact if + branch, to name the artifact

#while read line; do echo $line; done <  WorkflowRunLog.txt
jobId=$( tail -n 1 WorkflowRunLog.txt )
echo "${jobId}"
rm WorkflowRunLog.txt

#gh api --method DELETE -H "Accept: application/vnd.github+json" /repos/OWNER/REPO/actions/artifacts/ARTIFACT_ID
 content=$( gh api -H "Accept: application/vnd.github+json" /repos/nereagit/githubActions/actions/artifacts --jq  ".artifacts[] | select(.workflow_run.head_branch == \"concurrency-job-level\") | {id}") 

 