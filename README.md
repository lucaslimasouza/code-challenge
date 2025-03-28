## Code Challenge - Rails

Build a Rails API for implementing book reservation features and optimizing GET endpoints.

### API Endpoints
[ ] GET /api/books - List all books
[ ] GET /api/books/:id - Get book details

### Challenge Tasks
1. Implement Book Reservations endpoints
    - POST /api/books/:id/reserve 
[ ] Add email parameter for reservation
[ ] Change book status to :reserved when reserved
[ ] Handle edge cases (already reserved/checked out)
[ ] Write tests for reservation functionality
2. Optimize existing book GET endpoints
[ ] Optimize existing book GET endpoints
[ ] Implement query optimizations for large datasets
[ ] Add appropriate indexes if needed

---

## Running the project
- Run, in the root of the project:
  - `./run.sh`
- [http://localhost:3777/api/books](http://localhost:3777/api/books)
 

### Useful commands

Accessing the container shell
 - `./run.sh docker_shell`

Running rails commands
 - `./run.sh rails`

Run tests
 - `run.sh test`
