using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.Json;
//
using OpenBrokerREST_API.Models;
using OpenBrokerLib;
//Drapper
using Dapper;
//ClosedXML
using ClosedXML.Excel;

namespace OpenBrokerREST_API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GetDataInfo : ControllerBase
    {
        string connectionString = "Data Source=localhost;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=False";

        private readonly ILogger<GetDataInfo> _logger;

        public GetDataInfo(ILogger<GetDataInfo> logger)
        {
            _logger = logger;
        }

        [HttpGet("GetJson")]
        public IEnumerable<GetActualDataInfo> GetJson(DateTime from, DateTime to)
        {
            using (IDbConnection db = new SqlConnection(connectionString))
            {
                return db.Query<GetActualDataInfo>($"EXEC [OpenBroker].[dbo].[GetActualDataInfo] @from_date = '{from}', @to_date = '{to}'");
            }
        }

        [HttpGet("GetXLSx")]
        public FileResult GetXLSx(DateTime from, DateTime to)
        {
            using (IDbConnection db = new SqlConnection(connectionString))
            {
                IEnumerable<GetActualDataInfo> res = db.Query<GetActualDataInfo>($"EXEC [OpenBroker].[dbo].[GetActualDataInfo] @from_date = '{from}', @to_date = '{to}'");

                XLWorkbook workbook = new XLWorkbook();
                IXLWorksheet worksheet = workbook.Worksheets.Add("Лист1");
                
                worksheet.Cell("A1").Value = "Наименование книги";
                worksheet.Cell("B1").Value = "Авторы книги";
                worksheet.Cell("C1").Value = "Всего экземпляров (шт.)";
                worksheet.Cell("D1").Value = "Выдано за период (шт.)";
                worksheet.Cell("E1").Value = "Кол-во экземпляров в хранилище (шт.)";

                int iRow = 2;

                foreach(var Row in res)
                {
                    worksheet.Cell("A"+iRow).Value = Row.name;
                    worksheet.Cell("B" + iRow).Value = Row.authors;
                    worksheet.Cell("C" + iRow).Value = Row.count_item;
                    worksheet.Cell("D" + iRow).Value = Row.issue;
                    worksheet.Cell("E" + iRow).Value = Row.actual;
                    iRow++;
                }

                using (MemoryStream stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "result.xlsx");
                }
            }
        }
    }
}
