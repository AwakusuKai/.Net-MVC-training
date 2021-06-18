﻿using DataAccessLayer.Configuration;
using DataAccessLayer.Entities;
using DataAccessLayer.Interfaces;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DataAccessLayer.Repositories
{
    public class ProjectRepository : IRepository<Project>
    {
        private readonly IOptions<AppConfig> config;
        private  string connectionString
        {
            get
            {
                return config.Value.DefaultConnection;
            }
        }
        public ProjectRepository(IOptions<AppConfig> options)
        {
            config = options;
        }

        public IEnumerable<Project> GetAll()
        {
            
            List<Project> projects = new List<Project>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("spGetProjects", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    var project = new Project()
                    {
                        Id = Convert.ToInt32(rdr["Id"]),
                        Name = rdr["Name"].ToString(),
                        ShortName = rdr["ShortName"].ToString(),
                        Description = rdr["Description"].ToString()
                    };
                    projects.Add(project);
                }
            }
            return projects;
                
        }

        public void Create(Project project)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                var cmd = new SqlCommand("spCreateProject", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", project.Name);
                cmd.Parameters.AddWithValue("@ShortName", project.ShortName);
                cmd.Parameters.AddWithValue("@Description", project.Description);
                cmd.ExecuteNonQuery();
            }
        }
        
        public Project GetById(int id)
        {
            Project project = new Project();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("spGetProjectById", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    project.Id = Convert.ToInt32(rdr["Id"]);
                    project.Name = rdr["Name"].ToString();
                    project.ShortName = rdr["ShortName"].ToString();
                    project.Description = rdr["Description"].ToString();
                }
                return project;
            }
        }
        
        public void Update(Project project)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                var cmd = new SqlCommand("spUpdateProject", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.Parameters.AddWithValue("@Id", project.Id);
                cmd.Parameters.AddWithValue("@Name", project.Name);
                cmd.Parameters.AddWithValue("@ShortName", project.ShortName);
                cmd.Parameters.AddWithValue("@Description", project.Description);
                cmd.ExecuteNonQuery();
            }
        }
        public void Delete(int id)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                var cmd = new SqlCommand("spDeleteProjectById", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
