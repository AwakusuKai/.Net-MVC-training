﻿using DataAccessLayer.Entities;
using DataAccessLayer.Interfaces;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccessLayer.Repositories
{
    public class TaskRepository //: IRepository<Task>  
    {
       /* private DataContext db;
        public TaskRepository(DataContext context)
        {
            this.db = context;
        }
        public IEnumerable<Task> GetAll()
        {
            return db.Tasks.Include(o => o.Project).Include(o => o.Status).Include(o => o.Employee);
        }
        public Task Get(int id)
        {
            return db.Tasks.Find(id);
        }
        public void Create(Task task)
        {
            db.Tasks.Add(task);
        }
        public void Update(Task task)
        {
            db.Entry(task).State = EntityState.Modified;
        }
        public IEnumerable<Task> Find(Func<Task, Boolean> predicate)
        {
            return db.Tasks.Include(o => o.Project).Include(o => o.Status).Include(o => o.Employee).Where(predicate).ToList();
        }
        public void Delete(int id)
        {
            Task task = db.Tasks.Find(id);
            if (task != null)
                db.Tasks.Remove(task);
        }*/
    }
}
