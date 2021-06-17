﻿using AutoMapper;
using BusinessLogicLayer.DTO;
using BusinessLogicLayer.Infrastructure;
using BusinessLogicLayer.Interfaces;
using DataAccessLayer.Entities;
using DataAccessLayer.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer.Services
{
    public class ProjectService: IProjectService
    {
        IRepository<Project> ProjectRepository { get; set; }
        public ProjectService(IRepository<Project> projectRepository)
        {
            ProjectRepository = projectRepository;
        }

        public void CreateProject(ProjectDTO projectDTO)
        {
            Project project = new Project
            {
                Name = projectDTO.Name,
                ShortName = projectDTO.ShortName,
                Description = projectDTO.Description
            };
            ProjectRepository.Create(project);
        }
        public IEnumerable<ProjectDTO> GetProjects()
        {
            var mapper = new MapperConfiguration(cfg => cfg.CreateMap<Project, ProjectDTO>()).CreateMapper();
            return mapper.Map<IEnumerable<Project>, List<ProjectDTO>>(ProjectRepository.GetAll());
        }
        /*public ProjectDTO GetProject(int? id)
        {
            if (id == null)
                throw new ValidationException("Не установлено id проекта", "");
            var project = ProjectRepository.Get(id.Value);
            if (project == null)
                throw new ValidationException("Проект не найден", "");
            return new ProjectDTO { Name = project.Name, Id = project.Id, ShortName = project.ShortName};
        }*/

        /*public void Dispose()
        {
            ProjectRepository.Dispose();
        }*/

    }
}
