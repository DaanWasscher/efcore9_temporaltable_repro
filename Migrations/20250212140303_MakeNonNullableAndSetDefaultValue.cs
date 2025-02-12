using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace efcore_temporal_tables_default_constraint.Migrations
{
    /// <inheritdoc />
    public partial class MakeNonNullableAndSetDefaultValue : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "A",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "blabla",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "A",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldDefaultValue: "blabla");
        }
    }
}
