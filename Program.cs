using Microsoft.EntityFrameworkCore;

Console.Write("Hello world");

public class TestDbContext : DbContext
{
    public DbSet<EntityA> A { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer("TrustServerCertificate=True;Data Source=localhost,3341;Initial Catalog=efcore_temporal_migrations;Integrated Security=False;User ID=sa;Password=<PASSWORD>;MultipleActiveResultSets=True");
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        //Migration 1: Init
        modelBuilder.Entity<EntityA>().ToTable(e => e.IsTemporal());

        //Migration 2: Make "name" non nullable set default value
        modelBuilder.Entity<EntityA>().Property(e => e.Name).HasDefaultValue("blabla").IsRequired();

        //Migration 3: Set max length on "name" column
        modelBuilder.Entity<EntityA>().Property(e => e.Name).HasMaxLength(100);
    }
}

public class EntityA
{
    public int Id { get; set; }
    public required string Name { get; set; }
}