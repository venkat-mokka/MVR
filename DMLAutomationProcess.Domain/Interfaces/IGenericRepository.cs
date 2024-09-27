using System.Linq.Expressions;

namespace DMLAutomationProcess.Domain.Interfaces
{
    public interface IGenericRepository<T> where T : class
    {
        Task<int> AddAsync(T entity);
        Task<int> DeleteAsync(T entity);
        Task<IQueryable<T>> GetAllAsync();
        Task<int> UpdateAsync(T entity);
        Task<int> CountAsync();
        Task<T> FirstOrDefaultAsync(Expression<Func<T, bool>> match);
    }
}
