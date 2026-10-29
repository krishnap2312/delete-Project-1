export TF_LOG=DEBUG #TRACE, DEBUG, INFO, WARN, ERROR
export TF_LOG_PATH="./terraform-debug-$(date +'%Y-%m-%d_%H-%M-%S').log"


unset TF_LOG
unset TF_LOG_PATH