# Hotel Management System

This is a Hotel Management System project I worked on. The goal was to implement a fully functional system for managing rooms, bookings, customers, employees, billing, and reporting using Flutter and Firebase. The project follows Clean Architecture principles and MVVM structure for maintainable and testable code.

---

## Screens & Features

### Login
- Implemented login functionality for staff access.  
- Authentication integrated with Firebase.  

![Login](https://github.com/user-attachments/assets/6ecf2909-a9ee-4c92-aef3-25fbd4e82420)

---

### Rooms Management
- Add, edit, delete rooms.  
- Room status: Available, Under Maintenance, Housekeeping.  
- Assign rooms to specific floors.  
- Search and filter rooms by name, type, or status.  
- Show total number of rooms per status.  

**Screens:**  
![Room View](https://github.com/user-attachments/assets/e2151f6e-8d25-4a1d-8b57-8fd3a14f0b2b)  
![Add Room](https://github.com/user-attachments/assets/fa1297ef-fd57-4f70-9ec0-5769c6b6709e)  
![Edit/Delete Room](https://github.com/user-attachments/assets/20243e59-4c4c-4c9e-9507-3a8260311ea8)

---

### Booking Management
- Create, edit, and cancel bookings.  
- Automatic update of room status based on bookings.  
- Search and filter bookings by date, customer, or room.  
- Notifications for upcoming check-ins and check-outs.  

**Screens:**  
![Booking Room](https://github.com/user-attachments/assets/6964d607-dff9-426f-8845-f36b4eec9b66)  
![Booking View](https://github.com/user-attachments/assets/d7476898-4533-4548-8002-8af6123df681)  
![Booking Detail](https://github.com/user-attachments/assets/be8bc0dc-873f-428b-8d86-1a4a982c49ff)

---

### Excel & Invoice Management
- Export booking sheets and invoices to Excel.  
- Generate invoices in PDF format.  
- Platform-specific handling: Excel if available, Notepad fallback on Windows.  

**Screens:**  
![Extract Sheet Excel View](https://github.com/user-attachments/assets/6a8de825-253b-4c27-ab1f-f5243cdfbeb7)  
![Booking Sheet Excel](https://github.com/user-attachments/assets/fc6f522f-bd9a-4971-8fd6-4d73bb1fd680)  
![Invoice](https://github.com/user-attachments/assets/d266a407-32ab-4561-82ce-817de217fea9)

---

### Customer Management
- Add, edit, and delete customers.  
- Track booking history and customer details.  
- Search functionality by name, phone, or booking history.  

**Screens:**  
![Customers View](https://github.com/user-attachments/assets/88bf9fbd-a016-4852-99b5-f38115534f33)  
![Add New Customer](https://github.com/user-attachments/assets/7de60d99-97a2-4794-952d-9f62841f216d)  
![Delete Customer](https://github.com/user-attachments/assets/39f78a67-1ab4-4416-ad59-178be6b50bf9)

---

### Employees Management
- Add, edit, and manage employee accounts.  
- Track roles and permissions.  

**Screens:**  
![Employees Management View](https://github.com/user-attachments/assets/bb232f1f-6fd4-4b7c-b3b3-ed8207976fda)  
![Add New Employee](https://github.com/user-attachments/assets/cec31aab-16a0-4b74-a746-c283ecfccf16)

---

### Settings
- App settings management.  

**Screens:**  
![Settings](https://github.com/user-attachments/assets/d4d67f48-4992-4210-902b-483a256fd10a)

---

## Project Structure

- **features/**: Contains separate folders for Rooms, Booking, Customers, Employees. Each feature has Cubit/Bloc and UI.  
- **core/**: Shared utilities, constants, theme definitions, and custom widgets.  
- **data/**: Repositories and Firebase data sources.  
- **domain/**: Entities, use cases, and repository interfaces.  
- **presentation/**: Screens and Cubits managing state for each feature.

---
