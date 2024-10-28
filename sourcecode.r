# 加载必要的包
install.packages("sys")

# 读取数据集
cohort <- read.table("cohort.txt", header = TRUE) # 确保 "cohort.txt" 文件存在且格式正确

# 设置 datadist 对象
# ddist <- datadist(cohort)
# options(datadist="ddist")

# 拟合逻辑回归模型
# 公式格式为：Pathology ~ Age + Renal.length + EDV
smartckd <- glm(Pathology ~ Age + Renal.length + EDV, 
                family = binomial(link = "logit"), 
                data = cohort)

# 提取方差-协方差矩阵
vcov_matrix <- vcov(smartckd)
print(vcov_matrix)

# 提取各项的方差和协方差
variance_intercept <- vcov_matrix["(Intercept)", "(Intercept)"]
variance_age <- vcov_matrix["Age", "Age"]
variance_renal_length <- vcov_matrix["Renal.length", "Renal.length"]
variance_edv <- vcov_matrix["EDV", "EDV"]

covariance_intercept_age <- vcov_matrix["(Intercept)", "Age"]
covariance_intercept_renal_length <- vcov_matrix["(Intercept)", "Renal.length"]
covariance_intercept_edv <- vcov_matrix["(Intercept)", "EDV"]
covariance_age_renal_length <- vcov_matrix["Age", "Renal.length"]
covariance_age_edv <- vcov_matrix["Age", "EDV"]
covariance_renal_length_edv <- vcov_matrix["Renal.length", "EDV"]

# 打印出各项的方差和协方差，以便复制到 JavaScript 中使用
cat("const variance_intercept =", variance_intercept, ";\n")
cat("const variance_age =", variance_age, ";\n")
cat("const variance_renal_length =", variance_renal_length, ";\n")
cat("const variance_edv =", variance_edv, ";\n")

cat("const covariance_intercept_age =", covariance_intercept_age, ";\n")
cat("const covariance_intercept_renal_length =", covariance_intercept_renal_length, ";\n")
cat("const covariance_intercept_edv =", covariance_intercept_edv, ";\n")
cat("const covariance_age_renal_length =", covariance_age_renal_length, ";\n")
cat("const covariance_age_edv =", covariance_age_edv, ";\n")
cat("const covariance_renal_length_edv =", covariance_renal_length_edv, ";\n")
