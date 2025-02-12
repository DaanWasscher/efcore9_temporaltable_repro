using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace efcore_temporal_tables_default_constraint.Migrations
{
    /// <inheritdoc />
    public partial class SetMaxLength : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "A",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "blabla",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldDefaultValue: "blabla");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "A",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "blabla",
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100,
                oldDefaultValue: "blabla");
        }
    }
}
