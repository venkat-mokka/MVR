//using DMLAutomationProcess.App.Repositories;
//using DMLAutomationProcess.Domain.Interfaces;
//using DMLAutomationProcess.Infra.Dbcontext;
//using Microsoft.EntityFrameworkCore;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace DMLAutomationProcess.Infra.Repositories
//{
//    public class UOW : IUOW
//    {
//        private readonly ApplicationDbContext _context;
//        private bool _disposed;
//        private readonly Dictionary<Type, object> _repositories;

//        public UOW(ApplicationDbContext context)
//        {
//            _context = context;
//            _repositories = new Dictionary<Type, object>();
//            _disposed = false;
//            _context.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking; // Disable tracking by default
//        }

//        public IGenericRepository<T> Repository<T>() where T : class
//        {
//            var type = typeof(T);

//            if (_repositories.ContainsKey(type))
//            {
//                return (IGenericRepository<T>)_repositories[type];
//            }

//            var repository = new GenericRepository<T>(_context);
//            _repositories[type] = repository;
//            return repository;
//        }

//        public void SaveChanges()
//        {
//            _context.SaveChanges();
//        }

//        public async Task SaveChangesAsync()
//        {
//            await _context.SaveChangesAsync();
//        }

//        protected virtual void Dispose(bool disposing)
//        {
//            if (!_disposed)
//            {
//                if (disposing)
//                {
//                    _context.Dispose();
//                }
//                _disposed = true;
//            }
//        }

//        public void Dispose()
//        {
//            Dispose(true);
//            GC.SuppressFinalize(this);
//        }
//    }
//}
