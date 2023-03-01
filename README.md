
# Discover

Discover is a news app what fetch news from online api and store it into core data



## Authors

- [@saifrahmania](https://www.github.com/saifrahmania)




## API Reference

#### Get all items

```http
  GET /newsapi.org/v2/top-headlines/country/category/api_key
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `country` | `string` | **Required**. country code |
| `category` | `string` | **Optional**. type of category |


#### Get item

```http
  GET /newsapi.org/v2/top-headlines/country={code}/category={code}/api_key={api_key}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |




## Screenshots

![App Screenshot](https://i.ibb.co/ggj6FkX/Apple-i-Phone-11-Pro-Max-Presentation.png)
![App Screenshot](https://i.ibb.co/3WFJkkz/Apple-i-Phone-11-Pro-Max-Presentation-1.png)


## FAQ

#### Question 1: Which version does it support ? 

Answer: Minimum iOS version: 16.2

#### Question 2: How does it work while internet fails ?

Answer:  It fetches news from the core data. if the core data is empty it will show you the message that the internet is not available 

#### Question 3: Where does it store the bookmarks ?

Answer:  it also stores the core data.

#### Question 4: Does it store the news permanently ?

Answer:  it frees the memory if the data are not being used for a long time.

#### Question 5: Does it fetch news automatically ?

Answer:  Yes, in every 5 hours it refreshes the memory and fetches the latest news.

#### Question 6: What if I want to get new news ?

Answer:  You will pull the page and the api will be called with new news and the core data will be freed