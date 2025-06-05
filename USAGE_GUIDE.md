# How to Use BoilerPlate-02 to Start a New Project

This guide explains how to use BoilerPlate-02 as a foundation for your own full-stack web application. It covers cloning, setup, customization, and provides a simple example project: a basic Task Manager.

---

## 1. Clone the Boilerplate Repository

```bash
git clone https://github.com/whhsn/BoilerPlate-02.git my-task-manager
cd my-task-manager
```

## 2. Initialize a New Git Repository (Optional)
If you want a clean history for your new project:
```bash
rm -rf .git
git init
```

## 3. Run the Setup Script
This script will install dependencies, set up environments, and initialize the database.
```bash
bash setup_project.sh
```
Follow the prompts to create or select a conda environment.

## 4. Start the Backend and Frontend
In separate terminals, run:
```bash
bash run_backend.sh
```
```bash
bash run_frontend.sh
```
- Backend: http://localhost:5000
- Frontend: http://localhost:3000

## 5. Customize for Your Project

### Example: Simple Task Manager
Suppose you want to build a Task Manager app. Here’s how you’d start:

### Backend Changes
1. **Define a Task Model**
   - Edit `backend/app/models.py`:
     ```python
     from app import db
     class Task(db.Model):
         id = db.Column(db.Integer, primary_key=True)
         title = db.Column(db.String(128), nullable=False)
         completed = db.Column(db.Boolean, default=False)
     ```
2. **Create a Migration**
   ```bash
   cd backend
   flask db migrate -m "Add Task model"
   flask db upgrade
   cd ..
   ```
3. **Add Task API Endpoints**
   - In `backend/app/routes/task.py` (create if needed):
     ```python
     from flask import Blueprint, request, jsonify
     from app.models import Task, db
     task_bp = Blueprint('task', __name__)

     @task_bp.route('/api/tasks', methods=['GET'])
     def get_tasks():
         tasks = Task.query.all()
         return jsonify([{'id': t.id, 'title': t.title, 'completed': t.completed} for t in tasks])

     @task_bp.route('/api/tasks', methods=['POST'])
     def add_task():
         data = request.json
         task = Task(title=data['title'])
         db.session.add(task)
         db.session.commit()
         return jsonify({'id': task.id, 'title': task.title, 'completed': task.completed}), 201
     ```
   - Register the blueprint in `backend/app/__init__.py`:
     ```python
     from .routes.task import task_bp
     app.register_blueprint(task_bp)
     ```

### Frontend Changes
1. **Create a Task Page**
   - In `frontend/src/pages/TaskPage.tsx`:
     ```tsx
     import React, { useState, useEffect } from 'react';
     import axios from 'axios';
     const TaskPage = () => {
       const [tasks, setTasks] = useState([]);
       const [title, setTitle] = useState('');
       useEffect(() => {
         axios.get('/api/tasks').then(res => setTasks(res.data));
       }, []);
       const addTask = async () => {
         const res = await axios.post('/api/tasks', { title });
         setTasks([...tasks, res.data]);
         setTitle('');
       };
       return (
         <div>
           <h1>Tasks</h1>
           <input value={title} onChange={e => setTitle(e.target.value)} />
           <button onClick={addTask}>Add</button>
           <ul>
             {tasks.map((t: any) => (
               <li key={t.id}>{t.title} {t.completed ? '✅' : ''}</li>
             ))}
           </ul>
         </div>
       );
     };
     export default TaskPage;
     ```
2. **Add a Route**
   - Update your router (e.g., in `App.tsx`) to include the new page.

### 6. Update Documentation
- Edit `README.md` and other docs to reflect your new project purpose and features.

### 7. Commit and Push
```bash
git add .
git commit -m "Initial Task Manager setup"
git remote add origin <your-new-repo-url>
git push -u origin main
```

---

## Automated Project Creation Script

To make starting a new project even easier, BoilerPlate-02 provides an automated script:

### `new_project.sh`
This script clones the boilerplate, removes git history, re-initializes git, and runs the setup script for you. It is the fastest way to bootstrap a new project.

**Usage:**
```bash
bash new_project.sh <new_project_name>
```
- `<new_project_name>`: The name of your new project directory.

**What it does:**
1. Clones BoilerPlate-02 into a new directory with your chosen name.
2. Removes the existing git history and initializes a fresh git repository.
3. Runs the setup script to install dependencies and initialize the database.
4. Leaves you ready to start development immediately.

**Next steps:**
- Start the backend and frontend as described below.
- Begin customizing your project (see the Task Manager example for guidance).

---

## Summary
- BoilerPlate-02 lets you quickly bootstrap a secure, scalable full-stack app.
- Use the setup scripts to get started fast.
- Add your own models, APIs, and frontend pages as needed.
- See the included documentation for more advanced features (auth, i18n, testing, Docker, etc.).

For more details, see the other markdown files in this repository.
