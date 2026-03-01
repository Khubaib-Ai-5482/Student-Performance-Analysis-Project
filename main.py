import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, accuracy_score, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import label_binarize
from sklearn.metrics import roc_curve, auc

df = pd.read_csv("Student Performance Analysis Dataset.csv")
print(df.describe())

x = df.drop(["Final_Result"], axis=1)
y = df["Final_Result"]

cat_cols = x.select_dtypes(include="object").columns
for col in cat_cols:
    le = LabelEncoder()
    x[col] = le.fit_transform(x[col])

le_target = LabelEncoder()
y = le_target.fit_transform(y)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)

model = RandomForestClassifier(random_state=42)
model.fit(x_train, y_train)

y_pred = model.predict(x_test)
y_train_pred = model.predict(x_train)

train_acc = accuracy_score(y_train, y_train_pred)*100
test_acc = accuracy_score(y_test, y_pred)*100
print(f"Train Accuracy: {train_acc:.2f}%")
print(f"Test Accuracy: {test_acc:.2f}%")
print(classification_report(y_test, y_pred, target_names=le_target.classes_))

cm = confusion_matrix(y_test, y_pred)
plt.figure(figsize=(6,4))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=le_target.classes_, yticklabels=le_target.classes_)
plt.xlabel("Predicted")
plt.ylabel("Actual")
plt.show()

feat_importances = pd.Series(model.feature_importances_, index=x.columns).sort_values(ascending=False)
plt.figure(figsize=(8,5))
sns.barplot(x=feat_importances.values, y=feat_importances.index)
plt.show()

y_test_bin = label_binarize(y_test, classes=[0,1])
y_train_bin = label_binarize(y_train, classes=[0,1])
y_pred_proba = model.predict_proba(x_test)[:,1]
y_train_proba = model.predict_proba(x_train)[:,1]

fpr_test, tpr_test, _ = roc_curve(y_test_bin, y_pred_proba)
fpr_train, tpr_train, _ = roc_curve(y_train_bin, y_train_proba)
roc_auc_test = auc(fpr_test, tpr_test)
roc_auc_train = auc(fpr_train, tpr_train)

plt.figure(figsize=(6,5))
plt.plot(fpr_train, tpr_train, label=f'Train ROC (AUC={roc_auc_train:.2f})')
plt.plot(fpr_test, tpr_test, label=f'Test ROC (AUC={roc_auc_test:.2f})')
plt.plot([0,1],[0,1],'k--')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.legend()
plt.show()