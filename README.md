# Spotify Data Analysis Project

This project is a data analysis study on Spotify tracks dataset. It includes feature engineering, data cleaning, and visual analytics using Looker Studio and BigQuery.

##Dataset

- `tracks.csv`: Original dataset
- `track_artists.csv`: Track–artist relationships
- `tracks_analytics.csv`: Cleaned data used in ML and Looker

##Tools

- Google BigQuery
- Looker Studio
- Python (pandas, sklearn, matplotlib)

##Visualizations

- Average Popularity by Fashion Tag (Pop vs Non-Pop)
- Average Popularity by Tempo Category (Fast, Medium, Slow)
- Number of Tracks Released by Year
- Scatter Plot: Energy vs Popularity
- Scatter Plot: Valence vs Popularity
- Average Danceability by Release Year
- Distribution of Musical Keys in Tracks
- Bubble Chart: Energy vs Popularity by Musical Key (Bubble Size = Key Frequency)


##ML Results

- **Model Used**: Random Forest Regressor
- **Target**: Popularity prediction of tracks
- **Features**: Danceability, Energy, Valence, Tempo, Acousticness, etc.
- **Train/Test Split**: 80/20
- **R² Score**: 0.21  
- **Mean Squared Error (MSE)**: 264.61
- **Interpretation**: The model captured weak correlation between features and popularity. Results may be improved with additional features or refined data.


##Team

- Sila Bozkir
- Daryna Shmidova
- Arda Kusku
