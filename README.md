# E-Commerce Flutter Application

This is a simple e-commerce app built using Flutter and the **Bloc** pattern for state management. The app allows users to view products, add new products for sale, make purchases, and manage their profile. **Razorpay** is integrated for handling payments during the checkout process, **pagination** is implemented for the product listing screen, and **image caching** is added to improve performance when displaying product images.

Additionally, **dotenv** is used to securely store sensitive API keys, such as the **Razorpay API key**, to ensure better security and flexibility.

## Features

1. **Product Listing**:
    - Displays a list of available products.
    - Supports **pagination** to load products in chunks and improve performance with large datasets.
    - Each product shows the **name**, **price**, **seller information**, and a **"Buy Now"** button.
    - Product images are cached to avoid re-downloading them multiple times.

2. **Add Product**:
    - Allows users to add a new product for sale.
    - Form fields include:
        - **Product Name**
        - **Description**
        - **Price**
        - **Upload Product Image** (via image picker)

3. **Checkout**:
    - Manage cart, remove items, and proceed to checkout with **Razorpay** integration.
    - Displays the **total amount** for the selected products.
    - Users can proceed with payment via Razorpay.

4. **Profile**:
    - Displays user stats, such as the **number of items sold** and **number of items bought**.
    - Provides a summary of the **products listed** and **products purchased** by the user.

5. **Razorpay Payment Integration**:
    - Payments are processed via **Razorpay** during the checkout process.
    - Users can pay using various methods like credit/debit cards, UPI, wallets, etc.

6. **Pagination**:
    - The **Product Listing** screen supports pagination to load products in batches.
    - Users can load more products as they scroll down or interact with a "Load More" button.
    - Pagination improves performance, especially with large product catalogs.

7. **Image Caching**:
    - **Product images** are cached locally using the **CachedNetworkImage** package.
    - Images are fetched and stored on the device once, and subsequent accesses load the image from the cache, reducing network calls and improving performance.
    - Ensures a smoother user experience by preventing unnecessary image reloads.

## State Management

The app uses **Bloc** to manage state across the application:

- **ProductBloc**: Manages product data, including fetching products and pagination logic.
- **AddProductBloc**: Handles the form state for adding a product.
- **CartBloc**: Manages the cart functionality (adding/removing products).
- **ProfileBloc**: Manages user profile and statistics.

## Razorpay Payment Integration

For the payment process, **Razorpay** is integrated into the app to allow users to pay for their orders:

1. **Checkout**: When the user proceeds to checkout, Razorpay's checkout interface is invoked.
2. **Order Confirmation**: After a successful payment, the app confirms the order and updates the user's purchase history.
3. **Payment Gateway**: Razorpay provides a secure and simple payment solution that supports various payment methods like cards, wallets, and UPI.

### Steps for Razorpay Integration

1. **Razorpay API Key**: The app is configured with a test API key from Razorpay for handling payments.
2. **Razorpay SDK**: The Flutter app uses the Razorpay Flutter SDK to handle the payment flow.
3. **Payment Flow**:
    - User clicks on the **Checkout** button.
    - Razorpay’s checkout interface is launched.
    - User completes the payment process, and the app receives the response.
    - On success, the order is confirmed, and the cart is cleared.

For more information, refer to the [Razorpay Flutter documentation](https://razorpay.com/docs/payment-gateway/flutter/).

## Persistence

User data (products, cart, and purchase history) is stored locally using **Hive**.

## Pagination Implementation

- The **Product Listing** screen uses **pagination** to load products in chunks.
- **Pagination** is implemented by fetching a set of products at a time (e.g., 20 products per page) and loading more products as the user scrolls or clicks on a "Load More" button.
- This technique ensures efficient performance, especially with large product catalogs.


## Bonus

## Firebase integration done

## Local Search functionality allows users to search for products by name or description. The search results are filtered dynamically as the user types, ensuring a fast and responsive experience.

## Image Caching

- The app uses the **[CachedNetworkImage](https://pub.dev/packages/cached_network_image)** package to cache product images.
- Product images are downloaded once and cached locally, reducing the need to download images every time they are displayed.
- The cached images are automatically cleared after a set duration or when the app's cache is full.

### Implementation of Image Caching

1. **CachedNetworkImage** is used to load images from a URL and cache them on the device.
2. If the image is already cached, it will be loaded from the cache, improving the performance of the app and reducing network load.
3. If the image is not cached, it is fetched from the network and stored for subsequent use.