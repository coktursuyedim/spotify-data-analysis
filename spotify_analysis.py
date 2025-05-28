import pandas as pd

# Load the main dataset (tracks.csv)
df = pd.read_csv('tracks.csv')

# Show first few rows
print(df.head())

# Keep only relevant columns for analysis
selected_columns = [
    'id', 'name', 'popularity', 'duration_ms', 'explicit',
    'danceability', 'energy', 'key', 'loudness', 'mode',
    'speechiness', 'acousticness', 'instrumentalness',
    'liveness', 'valence', 'tempo'
]

df = df[selected_columns]

# Print shape and basic stats
print("Shape of dataset:", df.shape)
print("\nDataset summary:\n")
print(df.describe())

# Create tempo categories: slow, medium, fast
def categorize_tempo(tempo):
    if tempo < 90:
        return 'slow'
    elif 90 <= tempo <= 150:
        return 'medium'
    else:
        return 'fast'

df['tempo_category'] = df['tempo'].apply(categorize_tempo)

# Count how many songs fall into each tempo category
print("\nTempo Category Counts:")
print(df['tempo_category'].value_counts())

import matplotlib.pyplot as plt

# Count the values
tempo_counts = df['tempo_category'].value_counts()

# Plot a bar chart
plt.figure(figsize=(6,4))
tempo_counts.plot(kind='bar', color=['skyblue', 'lightgreen', 'salmon'])
plt.title('Tempo Category Distribution')
plt.xlabel('Tempo Category')
plt.ylabel('Number of Songs')
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig('visuals/tempo_category_bar.png')  # PNG olarak kaydedelim
plt.show()

# Scatter plot: Danceability vs Popularity
plt.figure(figsize=(8,6))
plt.scatter(df['danceability'], df['popularity'], alpha=0.3, color='orchid')
plt.title('Danceability vs Popularity')
plt.xlabel('Danceability')
plt.ylabel('Popularity')
plt.grid(True)
plt.tight_layout()
plt.savefig('visuals/danceability_vs_popularity.png')
plt.show()

# Scatter plot: Valence vs Popularity
plt.figure(figsize=(8,6))
plt.scatter(df['valence'], df['popularity'], alpha=0.3, color='gold')
plt.title('Valence vs Popularity')
plt.xlabel('Valence (Positivity)')
plt.ylabel('Popularity')
plt.grid(True)
plt.tight_layout()
plt.savefig('visuals/valence_vs_popularity.png')
plt.show()

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score

# Select numeric features and drop missing values
ml_df = df[['popularity', 'danceability', 'energy', 'valence', 'tempo']].dropna()

# Feature matrix (X) and target vector (y)
X = ml_df.drop('popularity', axis=1)
y = ml_df['popularity']

# Split the dataset into training and testing sets (80% train, 20% test)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Create and train a Random Forest model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Make predictions
y_pred = model.predict(X_test)

# Evaluate the model
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"\n🎯 Machine Learning Results:")
print(f"Mean Squared Error: {mse:.2f}")
print(f"R-squared Score: {r2:.2f}")

