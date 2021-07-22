
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
df = pd.read_csv("~/4Genes-boxplot.csv")
fig, axes = plt.subplots(2, 2)
sns.boxplot(x = df["Stage"], y = df["AK1"], data = df, ax=axes[0, 0])
sns.boxplot(x = df["Stage"], y = df["KAZALD1"], data = df, ax=axes[0, 1])
sns.boxplot(x = df["Stage"], y = df["SPIDR"], data = df, ax=axes[1, 0])
sns.boxplot(x = df["Stage"], y = df["ORAI1"], data = df, ax=axes[1, 1])

