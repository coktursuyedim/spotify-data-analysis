import pandas as pd

# Load the full dataset
df = pd.read_csv("tracks.csv")

# Estimate how many rows will bring it under 100MB
# (roughly: keep ~90% of 111MB → ~90,000 rows if original has ~100k+)
target_rows = int(len(df) * 0.89)  # Adjust this factor if needed

# Take a random sample of the data
df_sampled = df.sample(n=target_rows, random_state=42)

# Save the new smaller CSV
df_sampled.to_csv("tracks_small.csv", index=False)

print(f"✅ tracks_small.csv saved with {len(df_sampled)} rows.")
