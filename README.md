# Project Conversation
Project URL  https://project-managment-system-e06b670e9818.herokuapp.com/
## Project Overview
Project Conversation is a web application designed to facilitate project management and team collaboration. It allows users to create projects, track their status, add comments, and maintain a timeline of project activities.

### Key Features

- User authentication and authorization
- Project creation and management
- Status tracking with timeline
- Comment system for project discussions
- Responsive UI with modern design

## Product Requirements

### Initial Requirements from Product Team

**Q: We need a project management tool that allows users to create projects, track their status, and collaborate through comments. How can we implement this?**

**A: We'll build a Rails application with the following components:**
- User authentication using Devise
- Project model with status tracking
- Comment system for collaboration
- Timeline feature to track project history
- Service layer for business logic
- Clean, responsive UI

### Detailed Requirements and Answers

#### Project Structure
**Q: What information should be stored about a project?**
**A: We need basic project details like name, description, and current status.**

#### Status Management
**Q: What are the possible status values for a project?**
**A: Common statuses like "Not Started", "In Progress", "On Hold", "Completed"**

#### Comments
**Q: What information should be captured for each comment?**
**A: The comment text, who made it, and when it was made.**

#### User Management
**Q: Do we need user authentication for this system?**
**A: Yes, we should track who makes comments and status changes.**

#### Timeline Display
**Q: How should the conversation history be displayed?**
**A: Chronological order with clear distinction between comments and status changes.**

#### Permissions
**Q: Who can comment and who can edit projects?**
**A: Only the project creator can edit the project. Any authenticated user can comment on projects.**

## Database Design

### Tables and Relationships

1. **Users**
   - Primary key: `id`
   - Fields: `email`, `encrypted_password`, `name`, `created_at`, `updated_at`
   - Relationships:
     - Has many projects
     - Has many comments
     - Has many status changes

2. **Projects**
   - Primary key: `id`
   - Fields: `name`, `description`, `current_status`, `user_id`, `created_at`, `updated_at`
   - Relationships:
     - Belongs to user
     - Has many comments
     - Has many status changes

3. **Comments**
   - Primary key: `id`
   - Fields: `content`, `project_id`, `user_id`, `created_at`, `updated_at`
   - Relationships:
     - Belongs to project
     - Belongs to user

4. **Status Changes**
   - Primary key: `id`
   - Fields: `from_status`, `to_status`, `project_id`, `user_id`, `created_at`, `updated_at`
   - Relationships:
     - Belongs to project
     - Belongs to user

### Entity Relationship Diagram

```
User
 |
 |---> Project
 |      |
 |      |---> Comment
 |      |
 |      |---> StatusChange
 |
 |---> Comment
 |
 |---> StatusChange
```


## Design Patterns and SOLID Principles

### Design Patterns

1. **Service Pattern**
   - Implemented service classes (`ProjectService`, `CommentService`, `StatusChangeService`) to encapsulate business logic
   - Separates concerns between controllers and models
   - Makes the code more maintainable and testable

2. **Repository Pattern**
   - Service layer acts as a repository, abstracting data access
   - Provides a clean interface for controllers to interact with models

3. **Factory Pattern**
   - dynamic model object

4. **Observer Pattern**
   - Callbacks in models (e.g., `set_initial_status` in Project model)
   - Automatically sets default values or performs actions on model events


## Domain-Driven Design (DDD)

### Bounded Contexts

1. **Project Management**
    - Core domain for project creation and management
    - Entities: Project, StatusChange
    - Value Objects: Status

2. **Collaboration**
    - Supporting domain for user interaction
    - Entities: Comment, User

### Aggregates

1. **Project Aggregate**
    - Root: Project
    - Entities: StatusChange, Comment
    - Invariants: Status transitions must be valid

2. **User Aggregate**
    - Root: User
    - Entities: Project, Comment, StatusChange

### Domain Services

- `ProjectService`: Manages project lifecycle
- `StatusChangeService`: Handles status transitions
- `CommentService`: Manages comment creation and deletion

### Value Objects

- Status: Represents project status with validation rules

### SOLID Principles

1. **Single Responsibility Principle (SRP)**
   - Each class has a single responsibility
   - Models handle data and validations
   - Services handle business logic
   - Controllers handle HTTP requests and responses

2. **Open/Closed Principle (OCP)**
   - Services are designed to be extended without modification
   - New functionality can be added by creating new service methods

3. **Liskov Substitution Principle (LSP)**
   - All service classes inherit from `BaseService`
   - Any service can be used wherever a `BaseService` is expected

4. **Interface Segregation Principle (ISP)**
   - Services have focused interfaces
   - Controllers only interact with the methods they need

5. **Dependency Inversion Principle (DIP)**
   - High-level modules (controllers) depend on abstractions (services)
   - Low-level modules (services) implement those abstractions

## Used Gems

### Authentication and Authorization
- **Devise**: User authentication
  - Handles user registration, login, and session management
  - Provides secure password encryption
  - Configurable authentication strategies

- **CanCanCan**: Authorization
  - Defines user permissions
  - Restricts access to resources based on user roles

### Security
- **bcrypt**: Password hashing
  - Securely stores user passwords
  - Implements industry-standard hashing algorithms


### Testing
- **RSpec**: Testing framework
  - Behavior-driven development
  - Comprehensive test suite

- **FactoryBot**: Test data generation
  - Creates test fixtures
  - Simplifies test setup

- **Faker**: Fake data generation
  - Generates realistic test data
  - Improves test realism

### UI and Frontend
  - Responsive design
  - Modern UI components

- **Turbo**: Hotwire's SPA-like page accelerator
  - Improves page load times
  - Enhances user experience

- **Stimulus**: JavaScript framework
  - Enhances HTML with behavior
  - Minimal JavaScript

### Database and Caching
- **PostgreSQL**: Database
  - Reliable relational database
  - Advanced features for complex queries


### Development and Deployment
- **Kamal**: Deployment
  - Simplifies application deployment
  - Docker container support

- **Brakeman**: Security analysis
  - Identifies security vulnerabilities
  - Improves application security

- **Rubocop**: Code linting
  - Enforces coding standards
  - Improves code quality

## Getting Started

### Prerequisites
- Ruby 3.2.2
- Rails 8.0.1
- PostgreSQL

### Installation
1. Clone the repository
2. Run `bundle install`
3. Run `rails db:create db:migrate`
4. Run `rails server`
5. Visit `http://localhost:3000`

### Testing
Run the test suite with:
```
bundle exec rspec
```

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/abdelazizmohamed0/project_conversation.git
   cd project_conversation
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Setup database:
   ```bash
   rails db:create db:migrate
   ```

4. Start the development server:
   ```bash
   ./bin/dev
   ```

5. Visit `http://localhost:3000` in your browser

## Deployment

### Prerequisites

- Ruby 3.4.1
- PostgreSQL
- Heroku CLI
- Git

### Procfile Configuration

Create a `Procfile` in the root directory with the following content:
```
web: bundle exec puma -C config/puma.rb
release: bundle exec rails db:migrate
```

### Database Configuration

Update your `config/database.yml` with the following production configuration:
```yaml
production:
  url: <%= ENV['DATABASE_URL'] %>
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

### Environment Setup

1. Create a `.env` file in the project root with the following variables:
   ```
   RAILS_MASTER_KEY=your_master_key
   DATABASE_URL=postgresql://username:password@host:5432/database_name
   DATABASE_USER=your_database_user
   DATABASE_PASSWORD=your_database_password
   ```

2. Login to Heroku:
   ```bash
   heroku login
   ```

### Deployment Steps

1. Create a new Heroku app (if not already created):
   ```bash
   heroku create your-app-name
   ```

2. Add PostgreSQL addon:
   ```bash
   heroku addons:create heroku-postgresql:mini
   ```

3. Configure environment variables:
   ```bash
   heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)
   ```

4. Deploy to Heroku:
   ```bash
   git push heroku main
   ```

5. Run database migrations:
   ```bash
   heroku run rails db:migrate
   ```


### Monitoring and Maintenance

- View application logs:
  ```bash
  heroku logs --tail


