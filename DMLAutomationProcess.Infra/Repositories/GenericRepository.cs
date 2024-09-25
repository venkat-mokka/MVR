//using DMLAutomationProcess.Domain.Abstractions;
//using DMLAutomationProcess.Domain.Entities;
//using DMLAutomationProcess.Infra.Dbcontext;
//using Microsoft.EntityFrameworkCore;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace DMLAutomationProcess.App.Repositories
//{
//    public class GenericRepository<T> : IGenericRepository<T> where T : class
//    {
//        private readonly ApplicationDbContext _dbContext;

//        public GenericRepository(ApplicationDbContext dbContext) => _dbContext = dbContext;

//        public async Task<T> GetByIdAsync(int id)
//        {
//            return await _dbContext.Set<T>().FindAsync(id);
//        }

//        public async Task<List<T>> GetAllAsync()
//        {
//            return await _dbContext.Set<T>().ToListAsync();
//        }

//        public async Task<T> AddAsync(T entity)
//        {
//            var result = await _dbContext.Set<T>().AddAsync(entity);
//            await _dbContext.SaveChangesAsync();
//            return result.Entity;
//        }

//        public async Task<int> DeleteAsync(T entity)
//        {
//            _dbContext.Set<T>().Remove(entity);
//            return await _dbContext.SaveChangesAsync();
//        }

//        public async Task<int> UpdateAsync(T entity)
//        {
//            _dbContext.Set<T>().Update(entity);
//            return await _dbContext.SaveChangesAsync();
//        }
//    }
//}
