DECLARE @json VARCHAR(MAX) = '[
  {
    "Day Change Index": "FM",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 1,
    "Special Garment pu\/do": "W",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "7"
  },
  {
    "Day Change Index": "RM",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 2,
    "Special Garment pu\/do": "W",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "7"
  },
  {
    "Day Change Index": "FT",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 2,
    "Special Garment pu\/do": "R",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "7"
  },
  {
    "Day Change Index": "WM",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 3,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "7"
  },
  {
    "Day Change Index": "RT",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 3,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "7"
  },
  {
    "Day Change Index": "FW",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 3,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "7"
  },
  {
    "Day Change Index": "TM",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "WT",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "RW",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "FR",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "WR",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "M",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "RF",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "T",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "MT",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "R",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "TW",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "TR",
    "Garments Days to Turn Around": "3Day ->2Day",
    "Days Between Regular Deliverys": 7,
    "Special Garment pu\/do": "M",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "WF",
    "Garments Days to Turn Around": "3Day -> 2Day",
    "Days Between Regular Deliverys": 7,
    "Special Garment pu\/do": "T",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "MW",
    "Garments Days to Turn Around": "3Day -> 2Day",
    "Days Between Regular Deliverys": 7,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "TF",
    "Garments Days to Turn Around": "3Day -> 3Day",
    "Days Between Regular Deliverys": 8,
    "Special Garment pu\/do": "M",
    "Long Gap (8-9Days) Consider Special delivery": "Yes",
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "MR",
    "Garments Days to Turn Around": "3Day -> 3Day",
    "Days Between Regular Deliverys": 8,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": "Yes",
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "MF",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 9,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": "Yes",
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "7"
  },
  {
    "Day Change Index": "FM",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 1,
    "Special Garment pu\/do": "W",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "8"
  },
  {
    "Day Change Index": "RM",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 2,
    "Special Garment pu\/do": "W",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "8"
  },
  {
    "Day Change Index": "FT",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 2,
    "Special Garment pu\/do": "R",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "8"
  },
  {
    "Day Change Index": "WM",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 3,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "8"
  },
  {
    "Day Change Index": "RT",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 3,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "8"
  },
  {
    "Day Change Index": "FW",
    "Garments Days to Turn Around": "2Day",
    "Days Between Regular Deliverys": 3,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": "Yes",
    "Frequency": "8"
  },
  {
    "Day Change Index": "TM",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "WT",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "RW",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "FR",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 4,
    "Special Garment pu\/do": null,
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "WR",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "M",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "RF",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "T",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "MT",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "R",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "TW",
    "Garments Days to Turn Around": "2Day -> 2Day",
    "Days Between Regular Deliverys": 6,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "TR",
    "Garments Days to Turn Around": "3Day ->2Day",
    "Days Between Regular Deliverys": 7,
    "Special Garment pu\/do": "M",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "WF",
    "Garments Days to Turn Around": "3Day -> 2Day",
    "Days Between Regular Deliverys": 7,
    "Special Garment pu\/do": "T",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "MW",
    "Garments Days to Turn Around": "3Day -> 2Day",
    "Days Between Regular Deliverys": 7,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": null,
    "Short Gap (6-7days) Consider leaving extra product": "Yes",
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "TF",
    "Garments Days to Turn Around": "3Day -> 3Day",
    "Days Between Regular Deliverys": 8,
    "Special Garment pu\/do": "M",
    "Long Gap (8-9Days) Consider Special delivery": "Yes",
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "MR",
    "Garments Days to Turn Around": "3Day -> 3Day",
    "Days Between Regular Deliverys": 8,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": "Yes",
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  },
  {
    "Day Change Index": "MF",
    "Garments Days to Turn Around": "3Day",
    "Days Between Regular Deliverys": 9,
    "Special Garment pu\/do": "F",
    "Long Gap (8-9Days) Consider Special delivery": "Yes",
    "Short Gap (6-7days) Consider leaving extra product": null,
    "Special invoice needed to have invoice live week": null,
    "Frequency": "8"
  }
]
'; --Note JSON strings wrapped in single quotes is invalid JSON, I did it here because SSMS does not allow double qouted stings
INSERT INTO day_change_lookup
SELECT * FROM OPENJSON(@json) WITH
	([Day Change Index] VARCHAR(50),
	[Garments Days to Turn Around] VARCHAR(50),
	[Days Between Regular Deliverys] NUMERIC(3,0),
	[Special Garment pu/do] VARCHAR(50),
	[Long Gap (8-9Days) Consider Special delivery] VARCHAR(50),
	[Short Gap (6-7days) Consider leaving extra product] VARCHAR(50),
	[Special invoice needed to have invoice live week] VARCHAR(50),
	[Frequency] VARCHAR(50))